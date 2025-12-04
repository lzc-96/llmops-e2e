import pytest
from deepeval import assert_test
from deepeval.test_case import LLMTestCase
from deepeval.metrics import AnswerRelevancyMetric, ExactMatchMetric
from transformers import pipeline

# Initialize the Question-Answering pipeline with a pre-trained model
qa_pipeline = pipeline("question-answering", model="distilbert-base-uncased-distilled-squad")

# Define a function for testing the Question-Answering pipeline
def test_question_answering():
    # Define your test case with the input (context, question) and expected output
    context = "Hugging Face is a technology company that provides open-source NLP libraries..."
    question = "What does Hugging Face provide?"
    expected_answer = "open-source NLP libraries"

    # Get the actual output from the model
    result = qa_pipeline(question=question, context=context)
    actual_answer = result['answer']

    # Define the test case for DeepEval
    test_case = LLMTestCase(
        input=question,  # The question as input
        expected_output=expected_answer # The expected output from the model
        actual_output=actual_answer,  # The actual output from the model
        retrieval_context=[context]  # The context provided to the model
    )

    # Define the evaluation metric (Answer Relevancy, Exact Match, etc.)
    # Use AnswerRelevancy or ExactMatch depending on your requirement
    answer_relevancy_metric = AnswerRelevancyMetric(threshold=0.5)
    exact_match_metric = ExactMatchMetric()

    # Run the DeepEval test
    assert_test(test_case, [answer_relevancy_metric, exact_match_metric])

# # Run the test using pytest
# if __name__ == "__main__":
#     pytest.main()
